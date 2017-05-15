Received: from eggs.gnu.org ([2001:4830:134:3::10]:35202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dADpJ-0003i4-Bi
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dADpF-0002jA-Lt
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dADpF-0002iy-GQ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:06:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B3E7804EF
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 11:06:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170512175456.GJ2069@work-vm> (David Alan Gilbert's message of
	"Fri, 12 May 2017 18:54:57 +0100")
References: <20170512160055.9081-1-quintela@redhat.com>
	<20170512160055.9081-10-quintela@redhat.com>
	<20170512175456.GJ2069@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 13:05:59 +0200
Message-ID: <87d1bafkh4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/12] migration: Split vmstate-types.c
 from vmstate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Now one just has the interperter, and the other has the basic types.
>> Once there, add copyright boilerplate.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> I think this is generally OK, but as discussed on IRC, I think
> you need to check the licenses.

Changed to GPLv2 or later.

I just copied that from savevm.c, I should have known better and read it
O:-)

Later, Juan.
