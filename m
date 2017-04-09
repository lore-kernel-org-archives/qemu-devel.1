Received: from eggs.gnu.org ([2001:4830:134:3::10]:38127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cx6lI-0006dF-2m
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 02:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cx6lH-0005bJ-Al
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 02:55:48 -0400
Received: from mail-yw0-x234.google.com ([2607:f8b0:4002:c05::234]:36162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cx6lH-0005b9-27
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 02:55:47 -0400
Received: by mail-yw0-x234.google.com with SMTP id j9so25224252ywj.3
	for <qemu-devel@nongnu.org>; Sat, 08 Apr 2017 23:55:46 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Sun, 9 Apr 2017 02:55:15 -0400
Message-ID: <CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor R <boost.lists@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Mar 23, 2017 at 4:05 AM, Igor R <boost.lists@gmail.com> wrote:
> Hi,
>
> I'm trying to use the deterministic record/replay feature, and I would
> like to know which commit I should take to get it work.
> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381dc, as

Can you retry with the latest rc? There were some fixes regarding rr since rc0.

Thanks,
--
Pranith
