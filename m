Received: from eggs.gnu.org ([2001:4830:134:3::10]:38366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4DIV-0005kn-6c
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4DIS-0003RB-2f
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:19:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d4DIR-0003Pg-MZ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:19:23 -0400
Date: Fri, 28 Apr 2017 17:19:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170428211920.GA1383@flamenco>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
	<1493407045-24172-3-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493407045-24172-3-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 + 2/2] target/aarch64: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org

On Fri, Apr 28, 2017 at 15:17:25 -0400, Emilio G. Cota wrote:
> Measurements:
(snip)
> -                            SPECint06 (test set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
(snip)
> -                           SPECint06 (train set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
s/x86_64/aarch64/ , obviously.

		E.
