Received: from eggs.gnu.org ([2001:4830:134:3::10]:42287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJxX-0002bU-Ui
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJxU-0001SY-Rs
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:16:45 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJxU-0001SS-JI
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:16:44 -0400
Received: by mail-wr0-x230.google.com with SMTP id r103so93038427wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:16:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ardEEJr-QYd7ghkqKvENiro6k-rJno9rnruZx22=4TQ@mail.gmail.com>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-4-alex.bennee@linaro.org>
	<CAFEAcA9ardEEJr-QYd7ghkqKvENiro6k-rJno9rnruZx22=4TQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:16:20 +0100
Message-ID: <CAFEAcA_pF3V4sNzXwcO4fBu0sQCrQFUyQ_1DfXHOHfq+CBx9vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RISU PATCH v5 03/13] all: fix up code consitency
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

On 20 June 2017 at 14:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> Something seems to have gone wrong in this file -- note the extra indent
> of {} blocks after "case 0:". The others are all fine though so I'll
> just fix this locally.

...fixed up version applied to risu master.

thanks
-- PMM
