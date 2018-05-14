Received: from eggs.gnu.org ([2001:4830:134:3::10]:42874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fI985-0005Ld-5B
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fI981-0000u4-AM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:46:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fI981-0000tc-5X
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:46:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
	<eebc1ad7-2191-d9cc-81fd-5fefa9e3b1c8@linux.vnet.ibm.com>
	<87tvsfxkuq.fsf@dusky.pond.sub.org>
Date: Mon, 14 May 2018 10:46:42 +0200
In-Reply-To: <87tvsfxkuq.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 13 Apr 2018 16:05:33 +0200")
Message-ID: <87efie1v65.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qmp: 'wakeup-suspend-support' in
 query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>
>> Ping
>
> Michael, you reviewed v4 (at least in part), can you have a look?

Have these patches fallen through the cracks?
