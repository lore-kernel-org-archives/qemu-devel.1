Received: from eggs.gnu.org ([2001:4830:134:3::10]:48465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVZdu-00014g-42
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVZdp-0004eo-5o
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:43:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVZdp-0004ei-0v
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93A5816987
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:43:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180620094045.GC2549@work-vm> (David Alan Gilbert's message of
	"Wed, 20 Jun 2018 10:40:46 +0100")
References: <20180620081524.5751-1-quintela@redhat.com>
	<20180620081524.5751-3-quintela@redhat.com>
	<20180620094045.GC2549@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 20 Jun 2018 11:43:00 +0200
Message-ID: <87muvplrob.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v14 02/12] migration: Create multifd packet
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
>> We still don't put anything there.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Wrong r-b; that's:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Fixed, thanks.
