Received: from eggs.gnu.org ([2001:4830:134:3::10]:38378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1eDQE5-0007E6-IV
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 02:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1eDQE1-0006ev-KI
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 02:29:13 -0500
Received: from vps01.wiesinger.com ([46.36.37.179]:51546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lists@wiesinger.com>) id 1eDQE1-0006P9-CQ
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 02:29:09 -0500
References: <35eda6a9-086e-f899-e131-288f2346effe@wiesinger.com>
	<ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
	<3e1f41a8-faff-1858-6f0d-154694dff02d@wiesinger.com>
	<CABgObfYzngJPgS9agXMrRENVD_e+3Hm=y+KD5dp9na8jNwuumw@mail.gmail.com>
	<CABgObfZFwJMpU_D8SMkuiEhb0qBokHL0jpwmuzdE73TReHMFkg@mail.gmail.com>
	<0e69cbad-f658-03be-0191-1b6fe588147b@wiesinger.com>
	<CABgObfaw_bMQ=Dpfs=vh_AweaidqCZSBy4bDtsddk5DSKpRP8A@mail.gmail.com>
	<1b37b04c-349f-28f7-fb6c-fbbbe8415b33@wiesinger.com>
	<7757e373-c892-2824-d710-27ca57d479c4@redhat.com>
	<d5006c6b-c7d3-b002-b608-e4e05ee1f15c@wiesinger.com>
	<c0ca5671-790a-2e9b-b1d8-fecd6802ad79@redhat.com>
	<62d3868d-a2dd-d606-f1f1-1c05174c4b57@wiesinger.com>
	<c0591212-71a6-eb22-9550-2e17cd44324c@wiesinger.com>
	<fd1a2e70-0b37-2568-f408-b4616b70ec6e@redhat.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <1ddda0c7-479e-d0c9-fb03-2b56d98a6bf2@wiesinger.com>
Date: Sat, 11 Nov 2017 08:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <fd1a2e70-0b37-2568-f408-b4616b70ec6e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] kvm_intel fails to load on Conroe CPUs running
 Linux 4.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, KVM list <kvm@vger.kernel.org>

On 10.11.2017 17:29, Paolo Bonzini wrote:
> On 10/11/2017 16:33, Gerhard Wiesinger wrote:
>> Hello Paolo,
>>
>> Any update for a new patch?
> Yes,
>
> https://marc.info/?l=kvm&m=150997149623548&w=2
>
> Paolo

Works also for Fedora 26: 
https://koji.fedoraproject.org/koji/buildinfo?buildID=996781
kernel-4.13.12-200.fc26

Ready to release to 4.13.* upstream and 4.14 upstream kernels ...

https://bodhi.fedoraproject.org/updates/FEDORA-2017-abda708cee

Thnx.

Ciao,
Gerhard
