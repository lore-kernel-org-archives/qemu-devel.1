Received: from eggs.gnu.org ([2001:4830:134:3::10]:48658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGQI-0001Oc-8b
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGQF-0000fc-0m
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhGQE-0000ev-Re
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:32:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
Date: Mon, 14 Aug 2017 16:32:40 +0200
In-Reply-To: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com> (Vadim
	Galitsyn's message of "Fri, 28 Jul 2017 14:10:41 +0200")
Message-ID: <87bmnirzhz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] hmp,
 qmp: introduce memory-size-summary commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:

> Hi Guys,
>
> This thread is a continuation of discussion from:
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01565.html
>
> I will post changes list here in cover letter.

Looks good from a QMP point of view.  Just clean up the naming issues.

Eduardo, Igor, through which tree should this go?
