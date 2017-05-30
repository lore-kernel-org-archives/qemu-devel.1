Received: from eggs.gnu.org ([2001:4830:134:3::10]:42750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhXs-0006gK-0Y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhXr-0004kG-Aq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:50:48 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFhXr-0004k6-30
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:50:47 -0400
Received: by mail-wm0-x230.google.com with SMTP id b84so92791856wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 06:50:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa2c7203-644e-9209-91d8-e37c345b8240@amsat.org>
References: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
	<1493226792-3237-4-git-send-email-peter.maydell@linaro.org>
	<fa2c7203-644e-9209-91d8-e37c345b8240@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 14:50:25 +0100
Message-ID: <CAFEAcA9T_JHBu=vw6ohVj6YwqcC5GMQKB0HJA+ZPo746j+db8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/intc/arm_gicv3_cpuif:
 Fix priority masking for NS BPR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 14 May 2017 at 06:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> If you agree with upgrading those comments:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Yes, I agree with all those comment changes. Since they
were the only changes I've put the updated patchset
straight into target-arm.next.

Thanks for the careful review!

-- PMM
