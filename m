Received: from eggs.gnu.org ([2001:4830:134:3::10]:32996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP6Hp-0001Un-Nc
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP6Hk-0003aY-OC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:37:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eP6Hk-0003aC-IO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:37:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-28-marcandre.lureau@redhat.com>
Date: Wed, 13 Dec 2017 13:37:11 +0100
In-Reply-To: <20170911110623.24981-28-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:00 +0200")
Message-ID: <87efnyerd4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 27/50] qapi: add #if conditions to
 generated variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Adds blank lines to qmp-introspect.c, just like PATCH 12, which see.
