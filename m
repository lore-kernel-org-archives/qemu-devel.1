Received: from eggs.gnu.org ([2001:4830:134:3::10]:42444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTS7m-0006F3-PE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTS7j-0002RV-6c
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fTS7j-0002RN-1m
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD1D04023826
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:17:10 +0000 (UTC)
Date: Thu, 14 Jun 2018 15:17:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180614151709.000beb80@redhat.com>
In-Reply-To: <87efhdh4qu.fsf@dusky.pond.sub.org>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<87a7s1il25.fsf@dusky.pond.sub.org> <20180611120906.GE2661@work-vm>
	<87efhdh4qu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Mon, 11 Jun 2018 14:44:41 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:  
> >> Let's also provide "quit", both in HMP and QMP.  
> >
> > I tried enabling quit, but it fails with an incorrect
> > state transition.  
> 
> Igor, this one's for you.

I'll look into it
