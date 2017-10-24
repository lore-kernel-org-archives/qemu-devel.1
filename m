Received: from eggs.gnu.org ([2001:4830:134:3::10]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6uKC-0004Rv-4q
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6uK6-0005zl-CH
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:12:36 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:45151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6uK6-0005zd-66
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:12:30 -0400
Received: by mail-wm0-x231.google.com with SMTP id q124so13947682wmb.0
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 01:12:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171024074614.GC24198@redhat.com>
References: <20171013132507.GH20515@redhat.com>
	<CAFEAcA9qtKi+hPTOBfZqZ97p=J+_3hmq-aNT8m-9ypKN-=+-AA@mail.gmail.com>
	<20171024074203.GA24198@redhat.com> <20171024074614.GC24198@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 09:12:08 +0100
Message-ID: <CAFEAcA9UOPTAXWCNUK8XB-0R-tuyHmJQNmDVCQwdsCTATbzACQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU CII Best Practices record
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2017 at 08:46, Daniel P. Berrange <berrange@redhat.com> wrote:
> That said, I wonder if we should put 'security response handling' on the
> agenda for the QEMU mini summit tomorrow. In particular I think it is
> pretty bad that we don't publish any list of what CVEs affect QEMU and
> the GIT hash of the corresponding GIT master fix, nor mention them in
> the release notes for each major release.

Yep, happy to talk about that. Personally I'd like to see us doing
better here, but since I don't have the time to do it myself I can
understand if nobody else has the time to do it either :-)

thanks
-- PMM
