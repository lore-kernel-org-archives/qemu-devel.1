Received: from eggs.gnu.org ([2001:4830:134:3::10]:48941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1BNs-00073j-VR
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1BNs-0001uI-0b
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:40:29 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1BNr-0001sn-Qg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:40:27 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r190so2455299wme.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 05:40:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492680594151.52017@epfl.ch>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 13:40:05 +0100
Message-ID: <CAFEAcA8dows4s2MfpkK0ndMXXt3DgxBhqJCWJqpH1JCuieidiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 20 April 2017 at 10:29, Ajallooiean Hossein
<hossein.ajallooiean@epfl.ch> wrote:
> Thanks for getting back to me so quickly.
>
> I can boot Sparc64  -- ONLY when using the qemu from package manager. supposedly version 2.5
>
> but when building it myself (as i have some additions) - im getting this kernel error:

Sanity check -- if you build a purely upstream QEMU without any
of your additions does it still have this kernel error?

thanks
-- PMM
