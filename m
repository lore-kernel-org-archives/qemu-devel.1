Received: from eggs.gnu.org ([2001:4830:134:3::10]:52145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS2W2-0002Sy-2b
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS2Vy-0003Ak-45
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:07:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS2Vx-00039y-Uh
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:07:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <148190196925.25504.12830466137601571123.stgit@bahia>
Date: Fri, 13 Jan 2017 15:07:29 +0100
In-Reply-To: <148190196925.25504.12830466137601571123.stgit@bahia> (Greg
	Kurz's message of "Fri, 16 Dec 2016 16:26:09 +0100")
Message-ID: <87bmvboxy6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3] qapi: add explicit null to
 string input and output visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Greg Kurz <groug@kaod.org> writes:

> This may be used for deprecated object properties that are kept for
> backwards compatibility.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Happy to merge this as soon as we have an actual user.
