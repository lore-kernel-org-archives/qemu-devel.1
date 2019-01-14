Received: from eggs.gnu.org ([209.51.188.92]:53337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oO-0001Pl-AM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4oM-0002ZL-67
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4oK-0002UV-9z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:10:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id m1so118851wml.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:09:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 16:09:51 +0000
Message-Id: <20190114160956.7513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] gitdm updates with final 2018 stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b16:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-part2' into staging (2019-01-14 11:41:43 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-misc-gitdm-next-140119-1

for you to fetch changes up to 92329a7e70bc9755fd7114b8f91f95ed0b97648f:

  MAINTAINERS: add myself as a route for gitdm updates (2019-01-14 16:06:57 +0000)

----------------------------------------------------------------
gitdm updates with 2018 year end stats:

  git log --numstat --after="1/1/2018 00:00" --before="31/12/2018 23:59" | ~/src/gitdm.git/gitdm -n -l 10

  Top changeset contributors by employer
  Red Hat                   3091 (43.3%)
  Linaro                    1201 (16.8%)
  (None)                     484 (6.8%)
  IBM                        426 (6.0%)
  Academics (various)        186 (2.6%)
  Virtuozzo                  172 (2.4%)
  Wave Computing             118 (1.7%)
  Igalia                     109 (1.5%)
  Xilinx                     102 (1.4%)
  Cadence Design Systems      80 (1.1%)

  Top lines changed by employer
  Red Hat                   140523 (30.3%)
  Cadence Design Systems    81010 (17.5%)
  Linaro                    78098 (16.8%)
  Wave Computing            33134 (7.1%)
  IBM                       18918 (4.1%)
  SiFive                    14436 (3.1%)
  Academics (various)       11995 (2.6%)
  (None)                    11458 (2.5%)
  Virtuozzo                 10770 (2.3%)
  Oracle                    6698 (1.4%)

----------------------------------------------------------------
Alex Bennée (4):
      contrib/gitdm: add Nokia and Proxmox to the domain-map
      contrib/gitdm: add two more IBM'ers to group-map-ibm
      contrib/gitdm: add another name to WaveComp map
      MAINTAINERS: add myself as a route for gitdm updates

Joel Stanley (1):
      contrib/gitdm: Add other IBMers

 MAINTAINERS                      | 6 ++++++
 contrib/gitdm/domain-map         | 2 ++
 contrib/gitdm/group-map-ibm      | 7 +++++++
 contrib/gitdm/group-map-wavecomp | 1 +
 4 files changed, 16 insertions(+)

--
2.17.1
