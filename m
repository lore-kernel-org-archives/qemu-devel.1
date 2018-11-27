Received: from eggs.gnu.org ([2001:4830:134:3::10]:58638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1gRigC-000550-Fd
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1gRigB-0006ib-Ov
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:05:52 -0500
Date: Tue, 27 Nov 2018 11:05:40 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20181121151211.15997-18-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1811271105330.4577@sstabellini-ThinkPad-X260>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-18-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 17/18] MAINTAINERS: add myself as a Xen
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 21 Nov 2018, Paul Durrant wrote:
> I have made many significant contributions to the Xen code in QEMU,
> particularly the recent patches introducing a new PV device framework.
> I intend to make further significant contributions, porting other PV back-
> ends to the new framework with the intent of eventually removing the
> legacy code. It therefore seems reasonable that I become a maintiner of
> the Xen code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5871f035c3..0b668dd205 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -382,6 +382,7 @@ Guest CPU Cores (Xen):
>  X86
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
> +M: Paul Durrant <paul.durrant@citrix.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: */xen*
> -- 
> 2.11.0
> 
