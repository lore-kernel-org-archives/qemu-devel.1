Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDVwp-0001Kz-5b
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDVwl-0004xC-0h
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:08:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDVwk-0004x1-SP
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:07:58 -0400
Date: Tue, 1 May 2018 15:07:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180501140744.GD32129@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
	<20171106153342.24147-3-berrange@redhat.com>
	<1525183235.2540.664.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525183235.2540.664.camel@oracle.com>
Subject: Re: [Qemu-devel] [PULL v1 2/2] tests: Add test-listen - a stress
 test for QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, May 01, 2018 at 04:00:35PM +0200, Knut Omang wrote:
> Hi Peter,
> 
> Seems this test was lost along the way?
> 
> I thought it got merged with Daniel's fix to the potential leak 
> that the test exposed in your build, but it seems not?

I've never been able to get this test, nor another one of my own
to succesfully pass automated testing in all the various test
envs Peter and our many CI systems use.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
