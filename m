Received: from eggs.gnu.org ([2001:4830:134:3::10]:57773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVyfo-0008T2-3H
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVyfj-0005By-A1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cVyfj-0005Bm-2f
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:49:55 -0500
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
	<CAFEAcA8vRw=13Lj_98A+3NovSeTg6e0xBopdz9EcdEeUMjjZow@mail.gmail.com>
	<874m0x7ra2.fsf@dusky.pond.sub.org>
	<CAFEAcA_txNPj6JNDavmCREse98XTkQgiFAqx5Vf8KCCu9V-6mQ@mail.gmail.com>
	<878tq93guz.fsf@dusky.pond.sub.org>
	<CAFEAcA-zV8RWCXMCbAHLMEM1oEw7CWT_aDrTc49Xv_wSnMeAyw@mail.gmail.com>
	<CAFEAcA-fSJ5PfpKFaehruzjidBtmQP_435WLqgSLg=cQiETR8Q@mail.gmail.com>
	<87mvegu6m4.fsf@dusky.pond.sub.org> <87fuk8hira.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8d282de-7660-3305-7984-8a2301bc17f3@redhat.com>
Date: Tue, 24 Jan 2017 11:49:51 +0100
MIME-Version: 1.0
In-Reply-To: <87fuk8hira.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 24/01/2017 11:09, Markus Armbruster wrote:
> * commit f8bab10 build-sys: add txt documentation rules

This could be the culprit...

Paolo
