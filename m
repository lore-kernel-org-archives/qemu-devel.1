Received: from eggs.gnu.org ([2001:4830:134:3::10]:55169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqMjM-0000j4-3I
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqMjL-0004cU-Dj
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:33:56 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqMjL-0004cL-7F
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:33:55 -0400
Received: by mail-wm0-x232.google.com with SMTP id n11so16235483wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:33:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6ef847f2-1072-f6c9-dc15-f9d42cad4f3a@redhat.com>
References: <CAFEAcA9Z0X_nnYo7xEDY0arO0QF-REXxBNRqXv9vL8DhSikiyw@mail.gmail.com>
	<6ef847f2-1072-f6c9-dc15-f9d42cad4f3a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 16:33:33 +0000
Message-ID: <CAFEAcA-ZK=pqitQHFk+mcTB_nf6KSW71Cd_WXYAeLr0-u-xN_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] NetBSD doesn't boot under KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2017 at 16:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/03/2017 17:14, Peter Maydell wrote:
>> Any ideas? Does this sound like a KVM bug, or a guest bug?
>
> It sounds like a weird bug. :)  I'm downloading the image.

Thanks. (the freenode/#netbsd IRC channel seemed to have
some helpful people in it, if you get down to deciding it's
a NetBSD bug.)

thanks
-- PMM
