import styled from "styled-components";

const StyledLayout = styled.div`
  font-family: "Roboto", "Noto Sans TC", sans-serif !important;
`;

const Layout = ({ children }) => {
    return (
        <StyledLayout>
            <div className="container">{children}</div>
        </StyledLayout>
    );
};

export default Layout;