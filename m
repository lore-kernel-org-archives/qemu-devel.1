Received: from eggs.gnu.org ([2001:4830:134:3::10]:57993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dni6J-0002Dz-Ct
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dni6F-0007uE-Cv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dni6F-0007u3-6Q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:18:51 -0400
Date: Fri, 1 Sep 2017 10:18:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901091845.GB31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
	<CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
	<CAMzKsXuvdroUvT=6rjeTtM+FKHz6pat9Fgby5ayF_dZp9qaQaw@mail.gmail.com>
	<CAEkmjvVmHJfgtek9XDb77n12B-cV4=hLNJ66zQBLwOGDg6gUHQ@mail.gmail.com>
	<CAJTBuyj96Jd5Ys43sqVTR2y-Q2y-jRqSovHxRtQKGKKfezfZhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJTBuyj96Jd5Ys43sqVTR2y-Q2y-jRqSovHxRtQKGKKfezfZhg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/13] hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Izik Eidus <izik@veertu.com>
Cc: Frank Yang <lfy@google.com>, Sergio =?utf-8?B?QW5kcsOpcyBHw7NtZXo=?= del Real <sergio.g.delreal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, vpalatin@chromium.org, qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@gmail.com>, "J. Eason" <easonj@google.com>

On Fri, Sep 01, 2017 at 01:10:54AM +0300, Izik Eidus wrote:
> (BTW, I am pretty sure the copyright message that include GPLv2/GPLv3 and
> created all this mess was taken from QEMU itself ... :))

Sigh, you are right there. I've just checked and found a random splattering
of files with "GPL-v2-or-v3-only" license :-(

Just reinforces that we need to do a better (ie automated) job at reviewing
license declarations on submitted code in future.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
