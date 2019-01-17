Received: from eggs.gnu.org ([209.51.188.92]:58705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk69S-00084b-DX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk69O-0007LI-QF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:48:00 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk69N-0007HM-Vz
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:47:58 -0500
Received: by mail-wr1-f51.google.com with SMTP id s12so10672189wrt.4
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 03:47:55 -0800 (PST)
Date: Thu, 17 Jan 2019 12:47:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117114751.52h3aeg3e4lrf5i6@steredhat>
References: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] contrib: compile vhost-user-blk
 tool by default
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

On Wed, Jan 16, 2019 at 01:19:28PM +0800, Changpeng Liu wrote:
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
