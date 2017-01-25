Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWROm-0003wx-5K
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWROj-00023E-34
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:30:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWROi-00022r-Tb
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:30:17 -0500
References: <1484921496-11257-1-git-send-email-phil@philjordan.eu>
	<6ce45588-a312-aff1-6e7a-e54e29d4882c@redhat.com>
	<CAAibmn3ihTgE=U15e3PkR7P8WE3hEEnoAv8COcuQmZEX5EK9Gg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d1dec2a-7202-4a5e-8f4b-2af7e245c970@redhat.com>
Date: Wed, 25 Jan 2017 18:30:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAAibmn3ihTgE=U15e3PkR7P8WE3hEEnoAv8COcuQmZEX5EK9Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] x86-kvm: Fix Mac guest timekeeping
 by exposing TSC frequency in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org



On 25/01/2017 18:26, Phil Dennis-Jordan wrote:
> On 24 January 2017 at 12:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Looks good, thanks!  Queued patches 1 and 3 for 2.9 (patch 2 is in already).
> 
> Awesome, thanks for your help!
> 
> As there are now some minor merge conflicts with upstream, I've
> rebased the remaining 2 patches on latest master, they're in the
> vmware-cpuid-freq branch at https://github.com/pmj/qemu.git - in case
> that makes your job of merging them a bit easier.

I'll compare them with my own resolution, thanks!

Paolo
