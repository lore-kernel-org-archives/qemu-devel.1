Received: from eggs.gnu.org ([2001:4830:134:3::10]:37190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f88E2-000819-Tg
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f88Dz-0007BN-0N
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f88Dy-0007Ax-Px
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:47:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11B1A4E040
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 17:47:30 +0000 (UTC)
Date: Mon, 16 Apr 2018 14:47:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180416174727.GN29865@localhost.localdomain>
References: <1523900489-25950-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523900489-25950-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: Removed fixed
 CAN entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 16, 2018 at 07:41:29PM +0200, Thomas Huth wrote:
> The CAN device crashes have been fixed with the commit
> 089eac81e1d34d202471c0a023284f47f4c5f00e already.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued, thanks.

-- 
Eduardo
