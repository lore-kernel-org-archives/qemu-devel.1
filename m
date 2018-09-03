Received: from eggs.gnu.org ([2001:4830:134:3::10]:42604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlGL-0007aC-Eg
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlGH-0000TE-FV
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:35:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwlGH-0000T3-AA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:35:09 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1535778675-32170-4-git-send-email-wei@redhat.com> (Wei Huang's
	message of "Sat, 1 Sep 2018 01:11:14 -0400")
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-4-git-send-email-wei@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 11:35:04 +0200
Message-ID: <8736uq53g7.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 3/4] tests/migration: Add migration-test
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com

Wei Huang <wei@redhat.com> wrote:
> This patch moves the settings related migration-test from the
> migration-test.c file to a new header file.
>
> Signed-off-by: Wei Huang <wei@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
