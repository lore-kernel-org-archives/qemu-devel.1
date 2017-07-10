Received: from eggs.gnu.org ([2001:4830:134:3::10]:36690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUUsf-00062O-NU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUUsc-00084y-Ie
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dUUsc-00084M-Bz
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:21:22 -0400
Date: Mon, 10 Jul 2017 17:21:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170710092116.GC3738@pxdev.xzpeter.org>
References: <20170706183014.GH12152@localhost.localdomain>
	<1499396048-21657-1-git-send-email-peterx@redhat.com>
	<20170707121214.GS12152@localhost.localdomain>
	<20170710110202.4933fd05@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710110202.4933fd05@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2.2 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, lvivier@redhat.com, quintela@redhat.com, dgilbert@redhat.com

On Mon, Jul 10, 2017 at 11:02:02AM +0200, Greg Kurz wrote:
> On Fri, 7 Jul 2017 09:12:14 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Fri, Jul 07, 2017 at 10:54:08AM +0800, Peter Xu wrote:
> > > It's never documented, and now we have one more parameter for it (which
> > > obsoletes this one). Document it properly.
> > > 
> > > Although now when enforce-config-section is set, it'll override the
> > > other "-global" parameter, that is not necessarily a rule. Forbid that
> > > usage in the document.  
> > 
> > This paragraph looks obsolete now, as now the documentation
> > doesn't explicitly forbid mixing the two options.  If it gets
> > removed:
> > 
> 
> Same for me.
> 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks all for reviewing the patches!

-- 
Peter Xu
