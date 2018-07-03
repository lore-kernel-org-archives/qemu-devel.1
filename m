Received: from eggs.gnu.org ([2001:4830:134:3::10]:35001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faDyt-00068i-FV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faDyq-00010S-Di
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:36:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faDyq-000104-9a
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:36:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Date: Tue, 03 Jul 2018 07:35:58 +0200
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com> (Markus Armbruster's
	message of "Mon, 2 Jul 2018 18:21:46 +0200")
Message-ID: <87wouc7uf5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/32] qmp: Fixes and cleanups around OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Copying Michael Roth for the qemu-ga parts, belatedly.
