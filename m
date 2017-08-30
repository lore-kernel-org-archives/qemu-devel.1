Received: from eggs.gnu.org ([2001:4830:134:3::10]:40710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn2Pi-0000Yx-Tx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn2Pf-0003i9-2p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:48:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn2Pe-0003hG-RY
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:48:06 -0400
Received: by mail-wm0-x243.google.com with SMTP id m85so1182962wma.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 05:48:06 -0700 (PDT)
Date: Wed, 30 Aug 2017 13:48:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830124802.GO24565@stefanha-x1.localdomain>
References: <20170823084830.30500-1-frolland@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823084830.30500-1-frolland@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Add UUID support in initiator
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fred Rolland <rollandf@gmail.com>
Cc: qemu-devel@nongnu.org, Fred Rolland <frolland@redhat.com>

On Wed, Aug 23, 2017 at 11:48:30AM +0300, Fred Rolland wrote:
> Update doc with the usage of UUID for initiator name.
> 
> Related-To: https://bugzilla.redhat.com/1006468
> Signed-off-by: Fred Rolland <frolland@redhat.com>
> ---
>  qemu-doc.texi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
