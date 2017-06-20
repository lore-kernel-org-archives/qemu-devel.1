Received: from eggs.gnu.org ([2001:4830:134:3::10]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJtJ-00087Q-8l
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJtI-0008HY-Ey
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:12:25 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJtI-0008HU-85
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:12:24 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c11so37346589wrc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:12:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-13-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-13-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:12:02 +0100
Message-ID: <CAFEAcA_oRmWiQKyj=xSHyR1n-zDWfGJ4n3d4DzzWQtn3rTr1yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 12/13] new: record_traces.sh helper
 script
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
> A simple script to run through a bunch of binaries and generate their
> trace files.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v5
>   - author, license and usage header
> v3
>   - allow overriding of RISU binary
> ---
>  record_traces.sh | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100755 record_traces.sh

Another one for contrib/, I think.

thanks
-- PMM
