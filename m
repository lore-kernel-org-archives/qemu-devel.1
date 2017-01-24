Received: from eggs.gnu.org ([2001:4830:134:3::10]:42914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW80s-0004jB-9l
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW80p-0000KJ-SV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:48:22 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cW80p-0000Jz-OJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:48:19 -0500
Received: by mail-qt0-x241.google.com with SMTP id n13so28079359qtc.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 12:48:19 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-6-alex.bennee@linaro.org>
	<aa263f40-8df0-2b55-0fc6-0634a22b15d9@twiddle.net>
	<87mveg9pd4.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c64fe246-87fd-d4d3-9e0d-94c84472f60f@twiddle.net>
Date: Tue, 24 Jan 2017 12:48:15 -0800
MIME-Version: 1.0
In-Reply-To: <87mveg9pd4.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 05/27] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/24/2017 12:25 PM, Alex Bennée wrote:
> We are talking about doing the necessary annotation to all a givens
> targets loads and stores? I figured this code would morph and be tweaked
> when (if?) we get there.

Fair enough.


r~
