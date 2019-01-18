Received: from eggs.gnu.org ([209.51.188.92]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gkXT5-0002Mq-TK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gkXT5-0003z4-7K
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:58:07 -0500
Received: from mail-eopbgr780134.outbound.protection.outlook.com
	([40.107.78.134]:5043
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gkXT4-0003u7-RY
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:58:07 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 18 Jan 2019 16:58:01 +0000
Message-ID: <BN6PR2201MB12514D15D1681048BD350A80C69C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA_+=6Ls4wYWgGc4+vFvmLPhNMVjuonUsWv=bXKCp79n2Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_+=6Ls4wYWgGc4+vFvmLPhNMVjuonUsWv=bXKCp79n2Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 00/12] MIPS queue for January 17, 2019*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> Hi; I'm afraid this fails 'make check' on all platforms:

My bad. The culprit is found, the fix developed, tests rechecked, and the v=
2 of the pull request is going to be sent shortly.

My apologies, and thanks,
Aleksandar=
