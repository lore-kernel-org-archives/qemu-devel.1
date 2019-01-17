Received: from eggs.gnu.org ([209.51.188.92]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk6B0-0000nH-Qm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk6Ay-0000kA-Ip
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:49:37 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk6Au-0000fW-Sy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:49:34 -0500
Received: by mail-wr1-f42.google.com with SMTP id s12so10677708wrt.4
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 03:49:32 -0800 (PST)
Date: Thu, 17 Jan 2019 12:49:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117114929.2ye7d6joqfv7jaor@steredhat>
References: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
	<1547615970-23545-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547615970-23545-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] contrib/vhost-user-blk: fix the
 compilation issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com

Note: I removed my wrong e-mail address in CC.

On Wed, Jan 16, 2019 at 01:19:29PM +0800, Changpeng Liu wrote:
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
