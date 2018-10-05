Received: from eggs.gnu.org ([2001:4830:134:3::10]:39350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RHO-0007qI-Kq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RHN-0001Hy-NE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:40:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8RHN-0001G6-Fl
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:40:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id p23so1258542otf.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:40:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005163012.01bb7e73.cohuck@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<20181005163012.01bb7e73.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 15:40:12 +0100
Message-ID: <CAFEAcA9yHRkTv_uAfax6XuNXK_gTWZofpAcA35t=fr=n2K-Fzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2018 at 15:30, Cornelia Huck <cohuck@redhat.com> wrote:
> ISTR that we had a suggestion last time that we should provide
> qemu-kvm, qemu-tcg, etc. binaries...

That should shave off at least 0.1% from the length of the typical
QEMU command line :-)

thanks
-- PMM
