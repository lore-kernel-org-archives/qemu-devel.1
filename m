Received: from eggs.gnu.org ([2001:4830:134:3::10]:50849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4lmQ-0003KG-53
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4lmP-00018m-E9
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4lmP-00017f-7d
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:40:53 -0400
References: <1508232883-8790-1-git-send-email-yang.zhong@intel.com>
	<33bd9d2f-1b06-d73c-c4a9-5f0e69b8e1d5@redhat.com>
	<20171018103941.GA5506@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b231f94b-29d5-4d43-2b38-44e33089ff35@redhat.com>
Date: Wed, 18 Oct 2017 12:40:49 +0200
MIME-Version: 1.0
In-Reply-To: <20171018103941.GA5506@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86/cpufeatures: Enable new AVX512 cpu
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>, qemu-devel@nongnu.org

On 18/10/2017 12:39, Zhong Yang wrote:
>   Paolo, Thanks for review my patch!
> 
>   KVM patch is waiting for our kernel colleague to send kernel side patch,
>   My KVM patch has some header definition depency with kernel side.
> 
>   This Qemu patch has been verified on kernel and KVM's patch in newest 
>   kernel release.
> 
>   for this case, we need wait for KVM patch merged firstly?  Many thanks!

No, just checking!

Thanks,

Paolo
