Received: from eggs.gnu.org ([2001:4830:134:3::10]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhWgm-0007h1-Un
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhWgk-0002JR-Dw
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:55:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dhWgk-0002JE-7Q
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:54:58 -0400
Date: Tue, 15 Aug 2017 09:54:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170815095446.3b5e5391@nial.brq.redhat.com>
In-Reply-To: <87bmnirzhz.fsf@dusky.pond.sub.org>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<87bmnirzhz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 14 Aug 2017 16:32:40 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:
> 
> > Hi Guys,
> >
> > This thread is a continuation of discussion from:
> >   http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01565.html
> >
> > I will post changes list here in cover letter.  
> 
> Looks good from a QMP point of view.  Just clean up the naming issues.
> 
> Eduardo, Igor, through which tree should this go?
It's mostly QMP/HMP interface so it could go via QMP tree.
