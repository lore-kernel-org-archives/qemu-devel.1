Received: from eggs.gnu.org ([2001:4830:134:3::10]:58950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dY1es-0006j5-S2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dY1ep-00017R-Ia
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dY1ep-00016y-CQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:57:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35579C0587FA
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:57:42 +0000 (UTC)
Date: Thu, 20 Jul 2017 10:57:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170720025733.GE11032@lemon>
References: <20170719163108.26943-1-apahim@redhat.com>
	<20170719163108.26943-4-apahim@redhat.com>
	<20170720023854.GB11032@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170720023854.GB11032@lemon>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, crosa@redhat.com

On Thu, 07/20 10:38, Fam Zheng wrote:
> On Wed, 07/19 18:31, Amador Pahim wrote:
> > Let's make args public so users can extend it without felling like
> > abusing the internal API.
> 
> s/felling/feeling/ ?

Apart from that:

Reviewed-by: Fam Zheng <famz@redhat.com>
