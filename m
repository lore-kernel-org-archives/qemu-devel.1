Received: from eggs.gnu.org ([2001:4830:134:3::10]:36604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahzhanghaoyu@gmail.com>) id 1dusM9-0005Qu-7k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahzhanghaoyu@gmail.com>) id 1dusM6-0001TY-6H
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:40:53 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahzhanghaoyu@gmail.com>)
	id 1dusM6-0001P0-0j
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:40:50 -0400
Received: by mail-pf0-x241.google.com with SMTP id f84so1980811pfj.3
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 20:40:48 -0700 (PDT)
References: <20160809191216.GF2025@work-vm>
	<1470790447-83284-1-git-send-email-jiangshanlai@gmail.com>
	<F2CBF3009FA73547804AE4C663CAB28E0421B3D7@shsmsx102.ccr.corp.intel.com>
	<CAJhGHyAywEn_WLzZ-h=6RgHxN6QtAM0hc=RKvWJ59Ac_4dw_ZQ@mail.gmail.com>
	<F2CBF3009FA73547804AE4C663CAB28E0421B4EB@shsmsx102.ccr.corp.intel.com>
	<877fbpouoa.fsf@emacs.mitica>
	<F2CBF3009FA73547804AE4C663CAB28E0421C5EB@shsmsx102.ccr.corp.intel.com>
	<CAJhGHyAw+JakcdXeBxC0F1Zd-o5tMoEgn+-grV2G_qZYHdTnJg@mail.gmail.com>
	<CAJhGHyDoWZwvUZEWqfz9Hq5_E4Xdv6YeAe1=NUY+UO=Mz+rg=g@mail.gmail.com>
From: Zhang Haoyu <ahzhanghaoyu@gmail.com>
Message-ID: <35913e28-8feb-44d3-c5a6-12ceca8ce986@gmail.com>
Date: Thu, 21 Sep 2017 11:41:35 +0800
MIME-Version: 1.0
In-Reply-To: <CAJhGHyDoWZwvUZEWqfz9Hq5_E4Xdv6YeAe1=NUY+UO=Mz+rg=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] add migration capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>, "Li, Liang Z" <liang.z.li@intel.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "quintela@redhat.com" <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Jiangshan,

Any update from this patch?

Thanks,
Zhang Haoyu

On 2016/8/11 22:45, Lai Jiangshan wrote:
> Note, the old local migration patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2013-12/msg00073.html
> 
> this patch can be considered as a new local migration implementation,
> but with more restrictions (the memory must set shared when boot the qemu)
> 
