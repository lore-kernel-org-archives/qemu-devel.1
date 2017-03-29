Received: from eggs.gnu.org ([2001:4830:134:3::10]:51349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ct9V0-0006b6-9i
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ct9Uz-0001Bm-GT
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:02:38 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ct9Uz-0001Ai-AD
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:02:37 -0400
Received: by mail-wm0-x232.google.com with SMTP id o81so17226773wmb.1
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 02:02:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1C147BE6-2464-4B09-9083-E7F02F5235E3@gmail.com>
References: <1C147BE6-2464-4B09-9083-E7F02F5235E3@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Mar 2017 10:02:15 +0100
Message-ID: <CAFEAcA8afcrN3CQKF6Mwj8zSunnfnhUrzyNAeiYg-LcyP4MP3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Python support in Risu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 29 March 2017 at 03:27, G 3 <programmingkidx@gmail.com> wrote:
> I was wondering if someone wrote a risugen_*.pm file in python and it still
> worked with risugen, would you accept that patch?

This isn't possible, it is a perl program, not a python
program.

thanks
-- PMM
