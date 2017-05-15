Received: from eggs.gnu.org ([2001:4830:134:3::10]:42155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAJd7-00021G-PK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAJd4-0006AP-Kc
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAJd4-0006A1-E1
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:17:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170515135848.GL1201@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 15 May 2017 14:58:48 +0100")
References: <20170512155249.8853-1-quintela@redhat.com>
	<20170515135848.GL1201@stefanha-x1.localdomain>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 19:17:35 +0200
Message-ID: <8760h2dopc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, May 12, 2017 at 05:52:44PM +0200, Juan Quintela wrote:
>> Hi
>> 
>> 
>
> Thanks, applied to my staging tree:
> https://github.com/stefanha/qemu/commits/staging

Hi

As fast as I sent the PULL request, more comments appeared.

What do you preffer?
- drop the whole PULL request?
- drop the patch:  migration: Create block capabilities for shared and enable
  it has zero conflicts with the other patches
- let the PULL alone and I will sent fixes on top of that?

I would preffer option two, but that is up to you.

Sorry for the inconvenience.

Later, Juan.
