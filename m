Received: from eggs.gnu.org ([2001:4830:134:3::10]:36632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dm2iW-0004Nb-MU
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 14:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dm2iS-0005GQ-RE
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 14:55:28 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dm2iS-0005Fi-Jm
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 14:55:24 -0400
Received: by mail-lf0-f47.google.com with SMTP id d17so14921714lfe.1
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 11:55:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0e69cbad-f658-03be-0191-1b6fe588147b@wiesinger.com>
References: <35eda6a9-086e-f899-e131-288f2346effe@wiesinger.com>
	<ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
	<3e1f41a8-faff-1858-6f0d-154694dff02d@wiesinger.com>
	<CABgObfYzngJPgS9agXMrRENVD_e+3Hm=y+KD5dp9na8jNwuumw@mail.gmail.com>
	<CABgObfZFwJMpU_D8SMkuiEhb0qBokHL0jpwmuzdE73TReHMFkg@mail.gmail.com>
	<0e69cbad-f658-03be-0191-1b6fe588147b@wiesinger.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 27 Aug 2017 20:55:22 +0200
Message-ID: <CABgObfaw_bMQ=Dpfs=vh_AweaidqCZSBy4bDtsddk5DSKpRP8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Wiesinger, Gerhard" <lists@wiesinger.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>

Il 27 ago 2017 4:48 PM, "Gerhard Wiesinger" <lists@wiesinger.com> ha
scritto:

On 27.08.2017 14:03, Paolo Bonzini wrote:

>
> We will revert the patch, but 4.13.0 will not have the fix. Expect it in
> later stable kernels (because vacations).
>
>
Thnx. Why will 4.13.0 NOT have the fix?


Because maintainers are on vacation! :-)

Paolo
