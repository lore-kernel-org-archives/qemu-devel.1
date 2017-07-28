Received: from eggs.gnu.org ([2001:4830:134:3::10]:59979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dayIz-0002ED-LV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dayIy-0004r1-KU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:59:21 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:36813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dayIy-0004qg-FM
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:59:20 -0400
Received: by mail-io0-x229.google.com with SMTP id g35so54031237ioi.3
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 22:59:20 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170717102053.GH3640@redhat.com>
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
	<20170717102053.GH3640@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:59:19 -0300
Message-ID: <CAAdtpL6PA8Q0WKum_JnxWMDreps3EpAkK0vixMVYpS6PHXiPMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 7:20 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> I'm a little concerned about the fact that we've now got three different
> sets of tests that are being run on pull requests. There are the tests

hmm 4? there is also Shippable cross-builds:

  https://app.shippable.com/github/qemu/qemu/dashboard

[...]
> always run the exact same set of tests.  BUilding and maintaining such a
> system is hard work, potentially expensive (in terms of hardware required),
> and an ongoing full time job for at least one person, ideally more. So I

True :(

> realize I'm asking for magical dancing ponies here, but it is nice to be
> able to dream.
