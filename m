Received: from eggs.gnu.org ([2001:4830:134:3::10]:55078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWFEB-0003fD-HY
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWFE7-0005Q7-TT
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:39:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWFE7-0005K7-N1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:39:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205194701.17836-1-danielhb413@gmail.com>
	<87pnufjg3t.fsf@dusky.pond.sub.org>
	<20181207195400.GF7395@habkost.net>
Date: Mon, 10 Dec 2018 07:39:21 +0100
In-Reply-To: <20181207195400.GF7395@habkost.net> (Eduardo Habkost's message of
	"Fri, 7 Dec 2018 17:54:00 -0200")
Message-ID: <87o99topgm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 0/3] wakeup-from-suspend and
 system_wakeup changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, Dec 06, 2018 at 07:59:02AM +0100, Markus Armbruster wrote:
>> Daniel Henrique Barboza <danielhb413@gmail.com> writes:
>> 
>> > changes in v11:
>> > - fixed typos, changed version to 4.0 in patches 1 and 3
>> > - changed text in patch 2 to be less alarming
>> > - patch 3: changed error handling
>> > - previous version link:
>> > http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg01774.html
>> 
>> Looks ready to me.  Who's going to merge it?
>
> Do you mind merging it through the QMP tree?
>
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>

Can do.  Thanks!
