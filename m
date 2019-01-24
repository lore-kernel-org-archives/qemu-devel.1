Received: from eggs.gnu.org ([209.51.188.92]:53438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmbIi-0004Jp-Bd
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmbD6-0002b1-HO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:22:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmbD6-0002Y7-9u
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:22:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so5599794wrt.11
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 01:22:08 -0800 (PST)
Date: Thu, 24 Jan 2019 10:22:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190124092203.kvp2tlr3oxyks2wx@steredhat>
References: <20190124073626.20534-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124073626.20534-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc.c: fix one typo in function name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

CCing qemu-trivial@nongnu.org

On Thu, Jan 24, 2019 at 03:36:26PM +0800, Wei Yang wrote:
> Rename pc_get_hotpug_handler to pc_get_hotplug_handler.
> 
> No functional change.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/i386/pc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
