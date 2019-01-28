Received: from eggs.gnu.org ([209.51.188.92]:51207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1go2KX-0003Qx-85
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1go2KV-00078a-De
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:31:45 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1go2KR-0006zD-L4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:31:41 -0500
Received: by mail-wr1-f48.google.com with SMTP id s12so16966183wrt.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 00:31:37 -0800 (PST)
Date: Mon, 28 Jan 2019 09:31:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190128083133.dzqrazfffihpyfk7@steredhat>
References: <20190127114659.12881-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127114659.12881-1-samuel.thibault@ens-lyon.org>
Subject: Re: [Qemu-devel] [PATCH] slirp: replace QEMU_BUILD_BUG_ON with
 G_STATIC_ASSERT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, jan.kiszka@siemens.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, zhangckid@gmail.com

On Sun, Jan 27, 2019 at 12:46:59PM +0100, Samuel Thibault wrote:
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/ip.h       |  4 ++--
>  slirp/ip6.h      |  4 ++--
>  slirp/ip6_icmp.h | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
