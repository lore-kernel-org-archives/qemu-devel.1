Received: from eggs.gnu.org ([2001:4830:134:3::10]:59333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1feyMB-0002vX-6j
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1feyM6-0007cn-4I
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:55:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1feyM5-0007bU-13
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:55:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 695967A7E8
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:55:36 +0000 (UTC)
Date: Mon, 16 Jul 2018 09:55:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180716095533.7eefb71b.cohuck@redhat.com>
In-Reply-To: <20180716073226.21127-3-armbru@redhat.com>
References: <20180716073226.21127-1-armbru@redhat.com>
	<20180716073226.21127-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] MAINTAINERS: New section "Incompatible
 changes", copy libvir-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, thuth@redhat.com, pkrempa@redhat.com, berrange@redhat.com

On Mon, 16 Jul 2018 09:32:26 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Libvirt developers would like to be copied on patches to qemu-doc
> appendix "Deprecated features".  Do them the favor.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
