Received: from eggs.gnu.org ([2001:4830:134:3::10]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9qUJ-0002Zp-H5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9qUE-0007Po-Jj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9qUB-0007LY-BG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:47:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 744403082A42
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 11:47:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181003104605.8477-1-kchamart@redhat.com>
	<20181003190057.GG5738@habkost.net>
Date: Tue, 09 Oct 2018 13:47:30 +0200
In-Reply-To: <20181003190057.GG5738@habkost.net> (Eduardo Habkost's message of
	"Wed, 3 Oct 2018 16:00:57 -0300")
Message-ID: <87sh1fxrxp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi/misc.json: Remove superfluous words
 in CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Oct 03, 2018 at 12:46:05PM +0200, Kashyap Chamarthy wrote:
>> While at it, s/QMU/QEMU in @CpuDefinitionInfo.
>> 
>> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> Will this go through the QAPI tree?

Queued with the commit message updated as requested by Kashyap.  Thanks!
