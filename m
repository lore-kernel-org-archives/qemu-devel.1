Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BKa-0004RR-QV
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BKa-0005ct-4D
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:57:12 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:46517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0BKZ-0005cK-V7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:57:12 -0400
Received: by mail-qt0-x22f.google.com with SMTP id 6so18183522qtw.3
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:57:11 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-18-git-send-email-peter.maydell@linaro.org>
	<cd16f792-28a0-95b8-6a68-73f1427e6d38@linaro.org>
	<CAFEAcA8y8f27o=c_Cpox8KZWGZshER5PrztorPZUf+RFnAHrAg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f02972aa-e79c-e40c-c679-d1438f4b5308@linaro.org>
Date: Thu, 5 Oct 2017 14:57:08 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8y8f27o=c_Cpox8KZWGZshER5PrztorPZUf+RFnAHrAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/20] target/arm: Implement SG instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 10/05/2017 02:55 PM, Peter Maydell wrote:
> Oops. I missed this in my testing because it happens that the
> two halves of an SG instruction are the same value :-)

Hah.  I didn't notice that either.


r~
