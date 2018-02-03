Received: from eggs.gnu.org ([2001:4830:134:3::10]:60841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehw1i-0007PC-DU
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 06:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehw1d-0006GF-AZ
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 06:30:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehw1c-0006D9-R3
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 06:30:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Date: Sat, 03 Feb 2018 12:30:23 +0100
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com> (Markus Armbruster's
	message of "Fri, 2 Feb 2018 14:03:15 +0100")
Message-ID: <87zi4q2tv4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 00/21] Modularize generated QAPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Conflicts with commit a3b0dc7582 "qapi: add nbd-server-remove".  I
pushed the exact version I posted to my public repository:
http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qapi-monolith
