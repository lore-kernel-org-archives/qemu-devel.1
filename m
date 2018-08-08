Received: from eggs.gnu.org ([2001:4830:134:3::10]:33058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnP3W-00067R-80
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnP3O-00064Y-Th
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:03:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnP3O-00064G-Ox
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:03:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Date: Wed, 08 Aug 2018 16:03:08 +0200
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com> (Markus Armbruster's
	message of "Wed, 8 Aug 2018 14:02:38 +0200")
Message-ID: <87tvo5ufab.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/56] json: Fixes,
 error reporting improvements, cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Forgot to mention this is based on my "[PATCH v3 00/23] tests:
Compile-time format string checking for libqtest.h".

Based-on: 20180806065344.7103-1-armbru@redhat.com
