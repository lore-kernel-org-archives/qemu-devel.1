Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fjAfO-0001Nj-4B
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 17:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fjAfH-0005S2-Ts
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 17:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fjAfH-0005R9-NH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 17:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBFFA307D84C
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 21:52:45 +0000 (UTC)
Date: Fri, 27 Jul 2018 18:52:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180727215240.GX12380@localhost.localdomain>
References: <1532703031-166467-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532703031-166467-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] pc: acpi: fix memhp regression by
 reducing stub SRAT entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Fri, Jul 27, 2018 at 04:50:31PM +0200, Igor Mammedov wrote:
[...]
> NOTE TO MAINTAINER: UPDATE REFERRENCE APCI TABLE BLOBS IN TESTS

Why this needs to be done manually?  Can't the ACPI table update
be included in the e-mailed patch?

-- 
Eduardo
