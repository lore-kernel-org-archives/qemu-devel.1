Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cqLg1-0000k5-4O
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cqLfy-00067k-I6
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cqLfy-00067I-Ce
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EF02804EC
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 15:26:22 +0000 (UTC)
Date: Tue, 21 Mar 2017 16:26:17 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170321152617.l7kvunlg4zgbmqsu@eukaryote>
References: <20170319094631.17298-1-pbonzini@redhat.com>
	<f025cddc-b73a-ba88-c4ea-b262ddb043d9@redhat.com>
	<20170321123017.ab3lizoa2xd6jx5d@eukaryote>
	<edbcad8a-f9e1-8fab-c47b-b1e899f74bfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edbcad8a-f9e1-8fab-c47b-b1e899f74bfa@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] New blog post: "QEMU in the
 blogs: February 2017"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, Mar 21, 2017 at 01:35:02PM +0100, Paolo Bonzini wrote:
> 
> 
> On 21/03/2017 13:30, Kashyap Chamarthy wrote:
> > On Tue, Mar 21, 2017 at 01:09:19PM +0100, Thomas Huth wrote:
> >> On 19.03.2017 10:46, Paolo Bonzini wrote:
> >>> Just an idea... If this is useful, we can do it every month.  It only
> >>> takes ten minutes to skim planet.virt-tools.org and compile the list.
> >>
> >> Is it worth the effort? People can also quickly read through the planet
> >> blogs directly to get the same information...
> > 
> > While that's true, I _guess_ Paolo did that for those audience who only
> > follow the QEMU blog feed, and forget that the planet.virt-tools.org
> > exists.
> 
> Yeah, it's meant to be something easy to share or tweet (and it happens
> that ~1 per month is the frequency of my visits to planet.virt-tools.org).
> 
> Also, it helps keeping the QEMU blog alive. :)

Yes, I agree, FWIW:

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>


-- 
/kashyap
