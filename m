Received: from eggs.gnu.org ([2001:4830:134:3::10]:43467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dyyO8-0001z5-Cr
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 06:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dyyO5-0008L4-1I
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 06:55:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dyyO4-0008Kc-Pv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 06:55:48 -0400
Date: Mon, 2 Oct 2017 11:55:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171002105537.GA9597@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.4848.1506679941.14747.qemu-devel@gnu.org>
	<49B4FB8A-C439-4912-BD30-D4FECF709BB8@gmail.com>
	<20171002091838.GC27086@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002091838.GC27086@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for keycodemapdb
 GIT submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Mon, Oct 02, 2017 at 10:18:38AM +0100, Daniel P. Berrange wrote:
> On Fri, Sep 29, 2017 at 05:29:53PM -0400, Programmingkid wrote:
> > 
> > > On Sep 29, 2017, at 6:12 AM, qemu-devel-request@gnu.org wrote:
> > > 
> > > Message: 15
> > > Date: Fri, 29 Sep 2017 11:11:55 +0100
> > > From: "Daniel P. Berrange" <berrange@redhat.com <mailto:berrange@redhat.com>>
> > > To: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
> > > Cc: Fam Zheng <famz@redhat.com <mailto:famz@redhat.com>>, Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>>,
> > > 	Peter Maydell <peter.maydell@linaro.org <mailto:peter.maydell@linaro.org>>,	Paolo Bonzini
> > > 	<pbonzini@redhat.com <mailto:pbonzini@redhat.com>>,	"Daniel P. Berrange" <berrange@redhat.com <mailto:berrange@redhat.com>>
> > > Subject: [Qemu-devel] [PATCH v8 0/6] Initial support for keycodemapdb
> > > 	GIT submodule
> > > Message-ID: <20170929101201.21039-1-berrange@redhat.com <mailto:20170929101201.21039-1-berrange@redhat.com>>
> > > 
> > > This patch series is an update to:
> > > 
> > <snip>
> > 
> > For some reason this patch series isn't showing up in your patchworks page:
> > https://patchwork.ozlabs.org/project/qemu-devel/list/?submitter=2694
> 
> I dunno who maintains that service, but it is not showing *any* qemu-devel
> mail that has been sent since the list-id header changed from nongnu.org
> to gnu.org

Managed to track down an admin for patchwork and they fixed its list-id
filter, so it should start getting emails again. Unfortunately I think
any mails betwen Sept 28th and today will be lost from patchwork forever.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
