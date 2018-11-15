Received: from eggs.gnu.org ([2001:4830:134:3::10]:45169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNHpa-0004Kl-6a
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNHpZ-0006bZ-CA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:37:14 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNHpY-0006au-St
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:37:13 -0500
Received: by mail-ot1-x342.google.com with SMTP id w25so17289713otm.13
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:37:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <154221451552.7171.627568455010820489@sif>
References: <20181109161352.29873-1-mdroth@linux.vnet.ibm.com>
	<154221451552.7171.627568455010820489@sif>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 13:36:51 +0000
Message-ID: <CAFEAcA9rSfKNoAJb1KV2NbhNgLhbajrjAWKDk7NuT9VC2QDkQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH resend for-3.1] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 14 November 2018 at 16:55, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Michael Roth (2018-11-09 10:13:52)
>> This is needed to build skiboot from tarball-distributed sources
>> since the git data the make_release.sh script relies on to generate
>> it is not available.
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
> Hi Peter,
>
> Should I go ahead and send this as a standalone pull or should it go in
> through someone else?

Applied to master, thanks.

-- PMM
