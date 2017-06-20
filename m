Received: from eggs.gnu.org ([2001:4830:134:3::10]:39720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJoh-0004Is-RL
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJoh-0006mH-1g
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:07:39 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJog-0006ly-RD
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:07:38 -0400
Received: by mail-wr0-x233.google.com with SMTP id r103so92700759wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:07:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-5-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:07:17 +0100
Message-ID: <CAFEAcA_K=DSYhNHGPpb2eUWdrOyi-BpsDz7AHE-prmYZpMvkYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 04/13] build-all-archs: support
 --static flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v5
>   - swap with docker patch so later can be dropped if not wanted
> ---

Applied to master, thanks.

-- PMM
