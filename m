Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faOMw-0004sj-N9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faOMt-0003PD-Is
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:41:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faOMt-0003Os-Em
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:41:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAB1E406C7A9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 16:41:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 18:41:29 +0200
In-Reply-To: <20180703155648.11933-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 3 Jul 2018 17:56:34 +0200")
Message-ID: <87fu10clvq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 00/14] qapi: add #if pre-processor
 conditions to generated code (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Applied to qapi-next, testing still in progress.
